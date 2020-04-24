`ifndef __JVS_COMMON_DEFINES_SV__
 `define __JVS_COMMON_DEFINES_SV__

 `define JVS_WAVE(HIER) \
function string get_wave_name(); \
   string wave_name; \
   if ($test$plusargs("WAVE_NAME")) begin \
      void'($value$plusargs("WAVE_NAME=%s", wave_name)); \
   end \
   else begin \
      wave_name = "test"; \
   end \
   return wave_name; \
endfunction \
initial begin \
 `ifdef DUMP_FSDB \
  `ifndef GATE \
    $fsdbDumpfile($psprintf("%s.fsdb", get_wave_name())); \
  `else \
   $fsdbDumpfile($psprintf("%s_gate.fsdb", get_wave_name())); \
  `endif \
   $fsdbDumpvars("+all"); \
  `ifdef DUMP_MEM \
    $fsdbDumpDMA; \
  `endif \
  `ifdef DUMP_SVA \
    $fsdbDumpSVA; \
  `endif \
   $fsdbDumpon; \
 `elsif DUMP_VPD \
  `ifndef GATE \
    $vcdplusfile($psprintf("%s.vpd", get_wave_name())); \
  `else \
   $vcdplusfile($psprintf("%s_gate.vpd", get_wave_name())); \
  `endif \
   $vcdpluson(0, HIER); \
 `endif \
end   
   
`endif
