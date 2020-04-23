import re
from Simulator.xceliumInterface import xrunSimCheck
class userSimCheck(xrunSimCheck):
    regModelWarnPattern0 = r'.*a resource with meta characters in the field name has been created.*'
    regModelWarnPattern1 = r'.*already registered with factory. No string-based lookup support for multiple types with the same type name.'
    nullObjectFailPattern = r'Error-[NOA] Null object access'
    xrunErrorPattern = r'xmsim: \*E.*'
    guiDebugEndPattern = r'xcelium> exit'    

    def __init__(self):
        super (userSimCheck, self).__init__()
        self.setExcludeWarnPatterns(userSimCheck.regModelWarnPattern0)
        self.setExcludeWarnPatterns(userSimCheck.regModelWarnPattern1)
        self.setErrPatterns(userSimCheck.xrunErrorPattern)
        self.setErrPatterns(userSimCheck.nullObjectFailPattern)
        self.setEndFlagPatterns(userSimCheck.guiDebugEndPattern)
