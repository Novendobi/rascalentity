module DjTest

import DjangoSyntax;
import ParseTree;
import vis::Text;
import IO;
import Exception;
import DjAst;

void main(){
    try{
        loc FileLoc = |project://entitytask/src/resources/djangotest.py|;
        str DjangoEx = readFile(FileLoc);
        Tree DjTree = parse(#start[DJangoProgram], DjangoEx);
        println(prettyTree(DjTree));

        //implode
        DJangoProgram Djadt = implode(#DJangoProgram, DjTree);
        println(Djadt);
    }catch ParseError(e): println("error failed at <e>");
}