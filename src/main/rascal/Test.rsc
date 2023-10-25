module Test

import Syntax;
import ParseTree;
import vis::Text;
import IO;
import Exception;
import Ast;
import ModelToModel;
import ModelToText;

void main(){
    try{
        loc FileLoc = |project://entitytask/src/resources/test.tap|;
        str Entexample = readFile(FileLoc);
        Tree Enttree = parse(#start[Program], Entexample);
        println(prettyTree(Enttree));

        //implode to Ast
        Program Entadt = implode(#Program, Enttree);
        println(Entadt);

        //model to model
        DjEnt = transformProgramToDjango(Entadt);
        println("\nthis is the Django Ast: \n\n<DjEnt>");

        //model to Text
        str Djcode = djangoProgramToText(DjEnt);
        println("this is the code\n\n<Djcode>");
        writeFile(|project://entitytask/src/main/rascal/modeltotext/EntitytoDj.py|, Djcode);

    }catch ParseError(e): println("error failed at <e>");
}