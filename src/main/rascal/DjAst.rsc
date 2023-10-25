module DjAst

import DjangoSyntax;

data DJangoProgram
        = djentity(list[DjangoEntity] djentites)
        ;
data DjangoEntity
        = entitywithmtd(str name, list[DjAttributes] djattribs, list[Methods] methods)
        | entitynomtd(str name, list[DjAttributes] djattribs)
        ;
data DjAttributes
        = charfield(str name)
        | foreignkey(str name, str fkname)
        ;
data Methods
        = method(str name, str rstr, str sfname)
        ;