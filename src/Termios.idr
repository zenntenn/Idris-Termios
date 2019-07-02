||| Library for termios.h and similar actions in Idris
module Termios

import Control.ST
import Control.ST.ImplicitCall
import CFFI
import public Interfaces

%include C "sys/ioctl.h"
%include C "signal.h"
%lib C "termios"
%include C "Termios/termios_helper.h"
%link C "Termios/termios_helper.o"

%default total

||| Selects what to do for a given mode, only one option for now
modeSelect : (mode : TerminalMode) -> Type
modeSelect TUI = FancyConsole IO;
modeSelect Regular = ConsoleIO IO;

||| Implementation of FancyConsole for the standard POSIX IO terminal
public export FancyConsole IO where
  Status mode = State (modeSelect mode)
  initialize {terminal} = do ?hole2 (foreign FFI_C "initialize" (IO ()) );
                             ?hole
  cleanup = ?FancyConsole_rhs_3
  getCh = lift $ foreign FFI_C "wgetch" (IO Char)
