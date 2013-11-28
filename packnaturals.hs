import Data.List (elemIndex, sort)
import System.Environment (getArgs)

abc = "hdOBCH8Rz~926xKW_vLAwl0Ey3aYpUPkqZ7Q4fVjFgJcXDbTum1SteInGriMs5oN"

pack :: Integral i => [i] -> String
pack n = concatMap packInt n
  where
    packInt n
        | n < 2^5   = [abc !! fromIntegral (n + 2^5)]
        | otherwise = abc !! fromIntegral (n `mod` 2^5) : packInt (n `div` 2^5)

unpack :: String -> Maybe [Integer]
unpack s = case mapped of Just ns -> Just $ map unpackInteger $ groupByTerminator ns
                          Nothing -> Nothing
  where
    mapped = mapM (\e -> elemIndex e abc) s
    unpackInteger g = sum $ zipWith f g [0,5..]
      where
        f n pow = 2^pow * fromIntegral n :: Integer
    groupByTerminator [] = []
    groupByTerminator numlist = num : groupByTerminator rest
      where
        -- span splits the list such that fst does not include the
        -- matched element, but the matched element is a part of the number
        -- that we're extracting.
        num = fst spanned ++ [head (snd spanned) - 2^5]
        rest = tail $ snd spanned
        spanned = span (<2^5) numlist

deltify il = head il : zipWith subtract il (tail il)
undeltify = tail . scanl (+) 0
packUnordered = pack . deltify . sort
unpackUnordered l = fmap undeltify $ unpack l

main = do
  args <- getArgs
  let intArgs = map (\x -> read x :: Int) args
  let packed = pack intArgs
  let unpacked = unpack packed
  putStrLn $ "packed   : " ++ packed
  putStr $ "unpacked : "
  case unpacked of Nothing   -> putStrLn "ERROR"
                   Just nums -> putStrLn $ show nums
