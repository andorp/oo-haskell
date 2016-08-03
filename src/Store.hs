module Store
    ( newStore
    ) where

import Data.IORef


newStore :: a -> IO (a -> IO (), IO a)
newStore x = do
    store <- newIORef x

    let save y = writeIORef store y

    let load = readIORef store

    return (save, load)


main :: IO ()
main = do
    (save, load) <- newStore 0
    save 3
    x <- load
    print x
