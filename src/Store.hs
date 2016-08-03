module Store
    ( newStore
    , save
    , load
    ) where

import Data.IORef
import System.IO.Unsafe (unsafePerformIO)

newStore :: a -> IO (IORef a)
newStore = newIORef

save :: IORef a -> a -> IO ()
save = writeIORef

load :: IORef a -> IO a
load = readIORef

main :: IO ()
main = do
    store <- newStore 0
    save store 3
    x <- load store
    print x

