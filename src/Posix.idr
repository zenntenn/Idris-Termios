||| Library for termios.h and similar actions in Idris
module Termios.POSIX

import Control.ST
import Control.ST.ImplicitCall
import CFFI
import public Terminos

%include C "sys/ioctl.h"
%include C "signal.h"
%lib C "termios"
%include C "Termios/termios_helper.h"
%link C "Termios/termios_helper.o"

%default total

||| Type alias for IO' FFI_C
public export Cio : Type -> Type
Cio = IO' FFI_C

||| Selects what to do for a given mode, only one option for now
modeSelect : (mode : TerminalMode) -> Type
modeSelect TUI = Termios Cio


||| Implementation of FancyConsole for the standard POSIX IO terminal
public export Termios Cio where
  Status mode = State (modeSelect mode)
  initialize = ?initialize_rhs1 (foreign FFI_C "initialize" (Cio ()))       
  cleanup {terminal} = ?cleanup_rhs1 (foreign FFI_C "restore" (Cio ()) )              
  getCh = lift $ foreign FFI_C "wgetch" (Cio Char)

-- Reference code to both check that the types are sane, and to run integration tests
using (Termios Cio)
  partial 
  runCmd : ST Cio () [] 
  runCmd = do initialize
              someString1 <- getStr
              someString2 <- Control.ST.getStr
              someChar1 <- getCh
              someChar2 <- Termios.getCh
              putChar someChar2
              Control.ST.putChar someChar1
              putStr someString2
              Control.ST.putStr someString1
              cleanup

partial main : Cio ()
main = run runCmd
