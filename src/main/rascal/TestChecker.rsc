module TestChecker

extend Checker;
extend analysis::typepal::TestFramework;
import ParseTree;
import Syntax;

//implementing checker test
TModel syntaxTModelFromTree(Tree pt){
    return collectAndSolve(pt);
}

TModel syntaxTModelFromStr(str text){
    pt = parse(#start[Program], text);
    return syntaxTModelFromTree(pt);
}
        
test bool syntaxTests() {
    return runTests([|project://entitytask/src/resources/tests.ttl|],
    #start[Program], syntaxTModelFromTree);
}
bool main() = syntaxTests();