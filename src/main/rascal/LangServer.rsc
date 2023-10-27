module LangServer

import util::LanguageServer;
import util::IDEServices;
import ParseTree;
import util::Reflective;
import Syntax;
import Checker;
import TestChecker;
import IO;

set[LanguageService] entityLanguageContributor() = {
    parser(parser(#start[Program]))
};

int main() {
    registerLanguage(
        language(
            pathConfig(srcs=[|project://entitytask/src/main/rascal|]),
            "Entity Lang", // name of the language
            "test", //extension
            "LangServer", // module to import
            "entityLanguageContributor"
        )
    );
    return 0;
}
