module Termios.Interfaces

import Control.ST
import Control.ST.ImplicitCall
import CFFI

%access public export
%default total

||| The terminal mode being used
data TerminalMode = 
    ||| The specific terminal mode being used here
    TUI

interface ConsoleIO m => FancyConsole (m : Type -> Type) where    
    TuiStatus : (mode : TerminalMode) -> Type
    ||| Initializes the TUI mode
    initialize : ST m Var [add (TuiStatus TUI)]
    ||| Returns the console mode to the previous state
    cleanup : {terminal : Var} -> ST m Var [remove terminal (TuiStatus TUI)]
    ||| Gets a single char without waiting for character return
    getCh : ST m Char [terminal ::: TuiStatus TUI]