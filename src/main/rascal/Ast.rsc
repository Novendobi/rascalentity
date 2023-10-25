module Ast

import Syntax;

data Program
        = program(str name, list[Entity] entities)
        ;
data Entity
        = entityrpr(str ename, list[Attributes] attributes, Repr rpname)
        | entityWrpr(str ename, list[Attributes] attributes)
        ;
data Attributes
        = attribute(str aname, Types typename)
        | attributeAssoc(str aname, Types typename)
        ;
data Types
        = integer()
        | string()
        | boolean()
        | entityname(str name)
        ;
data Repr
        = repr(str rname)
        ;