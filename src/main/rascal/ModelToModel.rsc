module ModelToModel
import Ast;
import DjAst;

public DJangoProgram transformProgramToDjango(Program p) {
  switch(p) {
    case program(name, entities): 
      return djentity([transformEntityToDjango(e) | e <- entities]);
    default: return djentity([]);
  }
}

public DjangoEntity transformEntityToDjango(Entity e) {
  switch(e) {
    case entityrpr(ename, attributes, rpname): 
      return entitywithmtd(ename, [transformAttributeToDjango(a) | a <- attributes], [transformReprToMtd(rpname)]);
    case entityWrpr(str ename, list[Attributes] attributes): 
      return entitynomtd(ename, [transformAttributeToDjango(a) | a <- attributes]);
    default: return entitynomtd("", []);
  }
}

public Methods transformReprToMtd(Repr r){
    switch(r){
        case repr(rname):
            return method(rname, "", "");
    default:
        return method("", "", "");
    }
}

public DjAttributes transformAttributeToDjango(Attributes a) {
  switch(a) {
    case attributeAssoc(aname, typename): 
      return foreignkey(aname, transformTypeToDjango(typename));
    case attribute(aname, typename): 
      return charfield(aname);
    default: return charfield("");
  }
}

public str transformTypeToDjango(Types t) {
  switch(t) {
    case integer(): return "IntegerField";
    case string(): return "CharField";
    case boolean(): return "BooleanField";
    case entityname(str name): return name;
    default: return "";
  }
}