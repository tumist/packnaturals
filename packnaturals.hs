import Data.List (elemIndex)

abc = "hdOBCH8Rz~926xKW_vLAwl0Ey3aYpUPkqZ7Q4fVjFgJcXDbTum1SteInGriMs5oN"

pack :: [Int] -> String
pack n = concatMap packInt n
  where
    packInt n
        | n < 2^5    = [abc !! (n + 2^5)]
        | otherwise = abc !! (n `mod` 2^5) : packInt (n `div` 2^5)

unpack :: String -> Maybe [Int]
unpack s = case mapped of Just ns -> Just $ map unpackInt $ groupByTerminator ns
                          Nothing -> Nothing
  where
    mapped = mapM (\e -> elemIndex e abc) s
    unpackInt ns = sum $ zipWith (\n pow -> n * 2^pow) ns [0,5..]

    groupByTerminator [] = []
    groupByTerminator numlist = num : groupByTerminator rest
      where
        -- span splits the list such that fst does not include the
        -- matched element, but the matched element is a part of the number
        -- that we're extracting.
        num = fst spanned ++ [head (snd spanned) - 2^5]
        rest = tail $ snd spanned
        spanned = span (<2^5) numlist
