import fileinput
from pprint import pprint

__TYPEDIC__ = {}
__RULENUM__ = 0
__MINCONFIDENCE = 0.5

def getTypeDic():
    global __TYPEDIC__
    return __TYPEDIC__

def parseRules(inputfile,typesdic,minconfidence=0.5):
    global __RULENUM__, __MINCONFIDENCE__
    __RULENUM__ = 0
    __MINCONFIDENCE__ = minconfidence
    loadTypeDic(typesdic)
    rules = []
    for line in fileinput.input(inputfile):
      nl = parseLine(line)
      if nl != None:
        rules.append(parseLine(line))
    return rules

def parseLine(line):
    global __TYPEDIC__, __RULENUM__, __MINCONFIDENCE__
    if line[1] == '"':
        return None
    line = line.split('},{')
    LHS = line[0].split(',');
    RHS = line[1].split(',');
    confidence = RHS[1]
    if (float(confidence) < __MINCONFIDENCE__):
        return None
    antecedents = LHS[1:]
    antecedents[0] = antecedents[0].replace('"<{','')
    consequent = RHS[0]
    consequent = consequent.replace('}>"','')
    constype = __TYPEDIC__.get(consequent,"")
    rule = [antecedents, consequent, constype]
    return rule

def fireRules(rules,baskets,repeated = False):
    valid = {}
    invalid = {}
    for time, value in baskets.items():
        for iid, events in value.items():
            fired = []
            for r in rules:
                if all(x in events for x in r[0]):
                    if (not r[1] in fired) or repeated:
                        fired.append(r[1])
                        time = time+1
                        if (time in baskets and iid in baskets[time]) and r[1] in baskets[time][iid]:
                            if valid.get((time,r[2]),None) == None:
                                valid[time,r[2]] = 1
                            else:
                                valid[time,r[2]] += 1
                            if invalid.get((time,r[2]),None) == None: #Anadir a la otra lista el mismo indice para que haya consistencia
                                invalid[time,r[2]] = 0
                        else:
                            if invalid.get((time,r[2]),None) == None:
                                invalid[time,r[2]] = 1
                            else:
                                invalid[time,r[2]] += 1
                            if valid.get((time,r[2]),None) == None: #Anadir a la otra lista el mismo indice para que haya consistencia
                                valid[time,r[2]] = 0
                            
    return [valid, invalid]


def countBaskets(baskets):
    global __TYPEDIC__
    counts = {}
    for time in baskets:
        for installation in baskets[time]:
            for event in baskets[time][installation]:
                typ = __TYPEDIC__.get(event,"")
                if counts.get((time,typ),None) == None:
                    counts[time,typ] = 1
                else:
                    counts[time,typ] += 1
    return counts
                            
    

def parseBaskets(inputfile):
    baskets = {}
    for line in fileinput.input(inputfile):
      line = line.replace('\n','')
      line = line.replace('\r','')
      line = line.split(' ',3)
      innerdic = {int(line[0]) : line[3].split(' ')}
      if (int(line[1]) in baskets):
          baskets[int(line[1])].update(innerdic)
      else:
          baskets[int(line[1])] = innerdic
    return baskets
    # Time 0
    #  |
    #  +---- Installation 0 : [Events]
    #  +---- Installation 1 : [Events]
    #    ...
    # Time 1
    #  |
    #    ...

    
def loadTypeDic(dictfile):
    global __TYPEDIC__
    dicc = {}
    for line in fileinput.input(dictfile):
        line = line.replace('\n','')
        line = line.replace('\r','')
        line = line.split(",")
        key = line[1].replace('"','')
        value = line[2].replace('"','')
        dicc[key] = value
    __TYPEDIC__ = dicc

def fireRulesFromFiles(rulefile,dicfile,basketfile,repeat=False):
    rules = parseRules(rulefile,dicfile)
    baskets = parseBaskets(basketfile)
    valid = fireRules(rules,baskets,repeat)
    return valid

def writeResultsFromFiles(rulefile,dicfile,basketfile,outputfile,repeat=False):
    res = fireRulesFromFiles(rulefile,dicfile,basketfile,repeat)
    baskets = parseBaskets(basketfile)
    totals = countBaskets(baskets)
    fout = open(outputfile, "w")
    valid = res[0]
    invalid = res[1]
    fout.write("time alarm_type valid invalid real\n")
    for time, alarmtype in valid:
        total = totals.get((time,alarmtype),0)
        line = str(time)+' '+alarmtype+' '+str(valid[time,alarmtype])+' '+str(invalid[time,alarmtype])+' '+ str(total) +'\n'
        fout.write(line)
    fout.close()
  
