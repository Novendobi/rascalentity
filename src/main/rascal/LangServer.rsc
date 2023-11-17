module LangServer

import Syntax;
import ParseTree;
import util::Reflective;
import util::LanguageServer;
import TestChecker;
import Message;
import Prelude;
import IO;
extend analysis::typepal::TypePal;

set[LanguageService] testCont() = {
    parser(parser(#start[Program])),
    summarizer(testSummarizer, providesImplementations = false)
};

Summary testSummarizer(loc l, start[Program] input) {
    pt = parse(#start[Program], l).top;
    TModel model = syntaxTModelFromTree(input);

    // iprintToFile(|project://rascal-yaml/src/resources/mod.yml|, model);
    definitions = model.definitions;
    Summary val =  summary(l,
        messages = {<message.at, message> | message <- model.messages},
        references = {<definition, definitions[definition].defined> | definition <- definitions}
    );
    println(val);
    return val;
}

void main() {
  registerLanguage(
    language(
    pathConfig(srcs = [|std:///|, |project://entitytask/src/main/rascal|]),
    "Entity Lang", 
    "test", 
    "LangServer",
    "testCont"
    ));
}
