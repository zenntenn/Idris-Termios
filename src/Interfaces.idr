module Termios.Interfaces

import Control.ST
import Control.ST.ImplicitCall
import CFFI

%access public export
%default total

||| The terminal mode being used
data TerminalMode =
    ||| The previous terminal mode used
    Regular |
    ||| The specific terminal mode being used here
    TUI

interface ConsoleIO m => FancyConsole (m : Type -> Type) where    
    Status : (mode : TerminalMode) -> Type
    ||| Initializes the TUI mode
    initialize : {terminal : Var} -> ST m Var [terminal ::: Status Regular :-> Status TUI ]
    ||| Returns the console mode to the previous state
    cleanup : {terminal : Var} -> ST m Var [terminal ::: Status TUI :-> Status Regular]
    ||| Gets a single char without waiting for character return
    getCh : ST m Char [terminal ::: Status TUI]