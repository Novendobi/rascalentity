module DjangoSyntax

extend Lexical;

start syntax DJangoProgram
        = djentity: "from django.db import models" DjangoEntity* djentites
        ;
syntax DjangoEntity
        = entitywithmtd: "class" Id name "(models.Model):" DjAttributes* djattribs Methods+ methods
        | entitynomtd: "class" Id name "(models.Model):" DjAttributes* djattribs
        ;
syntax DjAttributes
        = charfield: Id name "=" "models.CharField(max_length=256)"
        | foreignkey: Id name "=" "models.ForeignKey" "(" Id fkname ")"
        ;
syntax Methods
        = method: "def" Id mname "(self)" ":" "return" String rstr ".format(self." Id sfname ")"
        ;
