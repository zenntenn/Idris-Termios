||| Interface for fine grained console actions
module Termios

import Control.ST
import Control.ST.ImplicitCall
import CFFI

%access public export
%default total

||| The terminal mode being used
data TerminalMode =
    ||| The specific terminal mode being used here
    TUI

interface (Monad m, ConsoleIO m) => Termios (m : Type -> Type) where    
    Status : (mode : TerminalMode) -> Type
    ||| Initializes the TUI mode
    initialize : ST m Var [add (Status TUI)]
    ||| Returns the console mode to the previous state
    cleanup : {terminal : Var} -> ST m () [remove terminal (Status TUI)] 
    ||| Gets a single char without waiting for character return
    getCh : {terminal : Var} -> ST m Char [terminal ::: Status TUI]