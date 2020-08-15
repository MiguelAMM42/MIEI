# Name  Asrc    Bsrc    Adest   Bdest   PCT Alub Aluop   Memop   Nextop  Next
# Initial instruction 
  .pos 0
  INIT  PC      None    AO      None    N   2    Add     IR      Disp    HA1     
# Conditional jump dispatches to here 
  .pos 2
  JMNT  T       None    PCAO    None    N   2    Add     IR      Disp    HA1     
  JMT   DI      None    PCAO    None    N   2    Add     IR      Disp    HA1     
# Main instruction dispatch is to here 
  .pos 16
  HA1   PC      None    None    None    N   1    Add     None    Chain   HA2     
  RE1   %esp    None    AO      None    N   4    Add     Read    Chain   RE2     
  OP1   R1a     R1b     None    None    Y   B    Fun     None    Chain   OP2     
  JM1   T       None    AO      None    N   4    Add     Read    BC      JMNT    
  CA1   %esp    None    None    None    Y   -4   Add     None    Chain   CA2     
  PU1   %esp    None    None    None    Y   -4   Add     None    Chain   PU2     
  PO1   %esp    None    AO      None    Y   4    Add     Read    Chain   PO2     
  RR1   T       R1a     AO      R1b     Y   2    Add     IR      Disp    HA1     
  IR1   T       None    AO      None    N   4    Add     Read    Chain   IR2     
  RM1   T       None    AO      None    N   4    Add     Read    Chain   RM2     
  MR1   T       None    AO      None    N   4    Add     Read    Chain   MR2     

# Name  Asrc    Bsrc    Adest   Bdest   PCT Alub Aluop   Memop   Nextop  Next
# The rest of the instructions
  .pos None
  OP2   PC      T       AO      R1b     N   2    Add     IR      Disp    HA1     
  IR2   T       DI      AO      R1b     Y   2    Add     IR      Disp    HA1     
  RM2   R1b     DI      None    None    Y   B    Add     None    Chain   RM3     
  RM3   R1a     T       DO      AO      N   1    None    Write   Chain   INIT    
  MR2   R1b     DI      None    None    Y   B    Add     None    Chain   MR3     
  MR3   None    T       None    AO      N   1    None    Read    Chain   MR4     
  MR4   PC      DI      AO      R1a     N   2    Add     IR      Disp    HA1     
  CA2   PC      T       AO      %esp    N   4    Add     Read    Chain   CA3     
  CA3   None    DI      None    PC      N   1    None    None    Chain   CA4     
  CA4   T       %esp    DO      AO      N   1    None    Write   Chain   INIT    
  RE2   DI      T       PCAO    %esp    N   2    Add     IR      Disp    HA1     
  PU2   R1b     T       DO      AO      N   1    None    Write   Chain   PU3     
  PU3   PC      T       AO      %esp    N   2    Add     IR      Disp    HA1     
  PO2   None    DI      None    R1b     N   1    None    None    Chain   PU3     
  HA2   None    None    None    None    Y   1    None    None    Halt    INIT
