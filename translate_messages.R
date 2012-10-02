# errortag <- "bd.Aspect_changed"
# cat(errortext[errortext$ADDITIONAL_TEXT==errortag,]$ERROR_TEXT)

translate_error <- function(errortag, escape_spaces=TRUE) {
  message <- errortext[errortext$ADDITIONAL_TEXT==errortag,]$ERROR_TEXT
  message <- gsub(" ","_",message)
  return(message)
}