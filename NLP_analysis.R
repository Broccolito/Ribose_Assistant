#Input can be string of any length or vector of strings
NLP_analysis = function(input_text){
  
  #Garbage Collection (Essential for rJava to work)
  gc()
  
  #Preprocessing
  input_text <- paste(input_text, collapse = " ")
  #print(input_text)
  
  input_text <- as.String(input_text)
  
  word_ann <- Maxent_Word_Token_Annotator()
  sent_ann <- Maxent_Sent_Token_Annotator()
  
  input_text_annotations <- annotate(input_text, list(sent_ann, word_ann))
  # head(input_text_annotations)
  
  input_text_doc <- AnnotatedPlainTextDocument(input_text, input_text_annotations)
  
  #Now we can extract information from our document using accessor functions like sents()
  #to get the sentences and words() to get the words. We could get just the plain text 
  #with as.character(input_text_doc).
  # words(input_text_doc) %>% head(10)
  # sents(input_text_doc) %>% head(2)
  
  #Annotating people and places
  
  #  "date", "location", "money", "organization", "percentage", "person", "misc"
  
  person_ann <- Maxent_Entity_Annotator(kind = "person")
  location_ann <- Maxent_Entity_Annotator(kind = "location")
  organization_ann <- Maxent_Entity_Annotator(kind = "organization")
  
  pipeline <- list(sent_ann,
                   word_ann,
                   person_ann,
                   location_ann,
                   organization_ann)
                   
  input_text_annotations <- annotate(input_text, pipeline)
  input_text_doc <- AnnotatedPlainTextDocument(input_text, input_text_annotations)
  
  select_kind = function(doc, kind){
    
    kind = as.character(kind)
    
    anno = doc$annotation
    cont = doc$content
    
    from = vector()
    to = vector()
    n = 1
    for(i in 1:length(anno)){
      try({
        if((anno[i]$features[[1]]$kind) == kind){
          from[n] = anno[i]$start
          to[n] = anno[i]$end
          n = n + 1
        }
      }, silent = TRUE)
    }
    kind_list = vector()
    
    if(length(from) > 0){
      for(i in 1:length(from)){
        kind_list[i] = as.character(substr(cont, from[i], to[i]))
      }
      return(kind_list)
    }else{
      return(NULL)
    }
  }
  
  person_list = select_kind(input_text_doc, "person")
  location_list = select_kind(input_text_doc, "location")
  organization_list = select_kind(input_text_doc, "organization")
  
  return(list(
    person_list,
    location_list,
    organization_list
  ))
  
}

get_category = function(list_from_NLP, kind = "person"){ 
  return(list_from_NLP[[which(c("person",
                                "location",
                                "organization") == kind)]])
}

#Test Data
#Read Dataa
# suppressWarnings({
#   Input_text <- readLines("input_text.txt")
# })
# a = NLP_analysis(input_text = Input_text)
# get_category(a, "location")



