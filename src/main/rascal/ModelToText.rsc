module ModelToText

import DjAst;
import List;

public str djangoProgramToText(DJangoProgram p) {
  switch(p) {
    case djentity(djentites): 
      return "from django.db import models\n\n<intercalate("\n\n", [djangoEntityToText(d) | d <- djentites])>";
    default: return "";
  }
}

public str djangoEntityToText(DjangoEntity e) {
  switch(e) {
    case entitywithmtd(name, djattribs, methods): 
      return 
"class <name>(models.Model):
    <intercalate("\n    ", [djAttributeToText(a) | a <- djattribs])>
    <intercalate("\n", [methodToText(m, name) | m <- methods])>";
    case entitynomtd(name, djattribs): 
      return 
"class <name>(models.Model):
    <intercalate("\n    ", [djAttributeToText(a) | a <- djattribs])>";
    default: return "";
  }
}

public str djAttributeToText(DjAttributes a) {
  switch(a) {
    case charfield(name): 
      return 
"<name> = models.CharField(max_length=256)";
    case foreignkey(name, fkname): 
      return 
"<name> = models.ForeignKey(<fkname>)";
    default: return "";
  }
}

public str methodToText(Methods m, str className) {
  switch(m) {
    case method(mname, rstr, sfname):
      return "
    def _unicode_(self):
        return \"<className>: {0}\".format(self.<mname>)
        ";
    default: return "";
  }
}