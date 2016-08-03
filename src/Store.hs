module Store
    ( newStore
    ) where

import Data.IORef

-- It looks like an OO object...
data Store a = Store {
      save :: a -> IO ()
    , load :: IO a
    }

-- It looks like a factory method...
newStore :: a -> IO (Store a)
newStore x = do
    storeRef <- newIORef x

    let saveImp y = writeIORef storeRef y

    let loadImp = readIORef storeRef

    return $ Store saveImp loadImp


main :: IO ()
main = do
    store <- newStore 0
    save store 3
    x <- load store
    print x
