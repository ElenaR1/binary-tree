--[1,2,3,4,5]->(1+2):(3+4):5:[]=[3,7,5]
sum2::[Int]->[Int]
sum2 []=[]
sum2 [x]=[x]
sum2 (x:y:xs)=(x+y):sum2 xs

--inward ["abcd","efgh","ijkl"]->"abcdlkjiefgh"
--["ab","cd","ef","gh"]="abhgcdfe"
inward::[String]->String
inward []=""
inward [x]=x
inward (x:xs)=x++ reverse (last xs) ++inward (init xs)



--3
f::Int->Int
f a=a*2

g::Int->Int
g a=a*3

--func [f,g] 2->[4,6]
func::(a->a)->(a->a)->a->[a]
func f g x= (f x):(g x):[]

--func2 [f,g] 2->[4,6]
func2::[(a->a)]->a->[a]
func2 [] y=[]
--func2 (x:xs) y=(x y):func2 xs y
func2 xs y=map (\f->f y) xs


func3::[(a->a)]->a->[a]
func3=map(\a f-> f a)

--taka raboti no iskame da nqmame nikakvi argumenti,a taka imame a
func3::a->[(a->a)]->[a]
func3 a=map(\f-> f a)

asdf 2 [f,g]->[4,6]
asdf :: a -> [a -> b] -> [b]
asdf = (zipWith (flip ($))) . repeat




f::Int->Int
f a=a*2

g::Int->Int
g a=a*3

asdf :: a -> [(a -> b)] -> [b]
asdf = (zipWith (flip ($))) . repeat
-- repeat приема а и връща безкраен [a] - безкраен списък от повторения на някаква стойност
-- типът на (flip ($)) е (flip ($)) :: a -> (a -> b) -> b
-- сиреч - стойност, функция и резултат от прилагането на функцията върху стойността
-- функцията, с която ще "zip"-ваме винаги трябва да е двуаргументна (нашата в случая е)
-- след функцията, zipWith чака два списъка, които да "zip"-не
-- първият трябва да е от тип "първи аргумент на функцията, с която zip-ваме" - тоест [a]
-- вторият - от тип "втори аргумент на функцията, с която zip-ваме - тоест - [(a -> b)]
-- asdf очаква това, което очаква repeat - някаква стойност от тип a
-- repeat я трансформира до [a] и я дава на (zipWith (flip ($)))
-- така вече имаме zipWith, който е получил и първия си списък за аргумент - този от стойности
-- следователно вече очаква само списъка от функции [(a -> b)]
-- в крайна сметка резултатът от цялото нещо е резултатът на zipWith, а именно [b]

-- защо последните редове са истина?
-- xs = [1,2,3] - [Int]
-- ys = ["a", "bb", "c"] - [String]
-- zipWith (\number string -> (length string) == number) xs ys
-- това извикване ще даде на анонимната функция елемент на xs и елемент на ys
-- като съответно първи и втори аргумент
-- типът на функцията е (Int -> String -> Bool)
-- "типът" на този zipWith е (Int -> String -> Bool) -> [Int] -> [String] -> [Bool]

-- всъщност идеята ми за задачата е
-- [5,5,5]
-- [(*3), (+2), (+3)]
-- магия
-- [15, 7, 8]
-- искам начин да zip-на тези два списъка и да получа този резултат

-- ако бяха в обратен ред
-- [(*3), (+2), (+3)]
-- [5,5,5]
-- магия = zipWith ($) xs ys
-- защото искам да приложа функция от xs към стойност от ys

-- да, ама животът е гаден
-- [5,5,5]
-- [(*3), (+2), (+3)]
-- тук просто мога да разменя местата на аргументите на $, за да мога да направя такъв zip
-- магия = zipWith (flip ($)) xs ys

-- докарахме го до момент, в който, имайки списък от стойности и списък от функции, можем
-- да докараме списък с резултати от прилагане на функции
-- zipWith (flip ($)) :: [a] -> [(a -> b)] -> [b]

-- да, ама животът е гаден
-- иска се изразът, който пишем, да има тип a -> [(a -> b)] -> [b]
-- пък ние можем само [a] -> [(a -> b)] -> [b]

-- трябва ни начин да накараме a да стане [a]
-- или, говорейки с конкретни стойности - 5 да стане [5,5,5...]
-- това, което искаме, може да се постигне с repeat
-- тя приема стойност и връща безкраен списък с повторения на тази стойност

-- затова храним zipWith (flip ($)) с резултата от repeat
-- и след това той си очаква [(a -> b)] -> [b]

-- repeat от своя страна чака a
-- и затова резултатът от цялата функция е
-- a -> [(a -> b)] -> [b]

func3 :: [(a -> a)] -> a -> [a]
func3 = map (flip ($))-- =map(\a f-> f a)

-- в този език, map чака две неща - *едноаргументна* функция
-- и списък, към чийто елементи да я приложи
-- (flip ($)) е двуаргументна функция от тип
-- (flip ($)) :: a -> (a -> a) -> a (да кажем)
-- НО защото сме в хаскел, (flip ($)) ВСЪЩНОСТ е едноаргументна функция (като всяка друга)
-- и по-точно: (flip ($)) :: a -> ((a -> a) -> a)
-- тоест чака стойност и връща едноаргументна функция (вече наистина :)),
-- която чака функция и връща резултат

-- тоест този map чака списък от стойности [a]
-- и връща списък от типа [(a -> a) -> a)] (защото това връща (flip ($)) като вече му е приложена стойност)
-- а типът на func3 е нещо съвсем различно


--zipWith ($) [(+1),(+2),(+3)] [1,2,3] ->[2,4,6]
-- zipWith (flip($)) [1,2,3] [(+1),(+2),(+3)] ->[2,4,6]



--poslednata zadacha e z sortirane
