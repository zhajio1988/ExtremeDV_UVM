import re
from Simulator.vcsInterface import vcsSimCheck
class userSimCheck(vcsSimCheck):
    regModelWarnPattern0 = r'.*a resource with meta characters in the field name has been created.*'
    regModelWarnPattern1 = r'.*already registered with factory. No string-based lookup support for multiple types with the same type name.'
    cevaTestFailPattern = r'.*TEST FAILED.*'
    nullObjectFailPattern = r'Error-[NOA] Null object access'
    cevaReportPattern = r'.*SIMULATION SUMMARY.*'    

    def __init__(self):
        super (userSimCheck, self).__init__()
        self.setExcludeWarnPatterns(userSimCheck.regModelWarnPattern0)
        self.setExcludeWarnPatterns(userSimCheck.regModelWarnPattern1)
        self.setErrPatterns(userSimCheck.cevaTestFailPattern)
        self.setErrPatterns(userSimCheck.nullObjectFailPattern)
        self.setEndFlagPatterns(userSimCheck.cevaReportPattern)
