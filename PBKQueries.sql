-- What grades are stored in the database?
select * from Grade;
-- 1 - 5th,

-- What emotions may be associated with a poem?
select * 
from Emotion;
-- anger, fear, sadness joy,

-- How many poems are in the database?
select count (id) as 'total number of poems'
from Poem;
-- 32842 poems

-- Sort authors alphabetically by name. What are the names of the top 76 authors?
select TOP (76) Author.Name 
from Author
order by Author.Name asc;


-- Starting with the above query, add the grade of each of the authors.
select TOP (76) Author.Name, Grade.Name
from Author
left join Grade on Author.GradeId = Grade.Id
order by Author.Name asc;

-- Starting with the above query, add the recorded gender of each of the authors.
select TOP (76) Author.Name, Grade.Name, Gender.Name
from Author
left join Grade on Author.GradeId = Grade.Id
left join Gender on Author.GenderId = Gender.Id
order by Author.Name asc;

-- What is the total number of words in all poems in the database?
select sum (WordCount) as 'total words'
from Poem;

-- Which poem has the fewest characters?
select top (1) *
from Poem
order by Poem.CharCount asc;

-- How many authors are in the third grade?
select count (Author.Id) as 'total 3rd graders'
from author
join grade on author.GradeId = Grade.Id
where grade.Name = '3rd Grade';

-- How many total authors are in the first through third grades?
select count (Author.Id) as 'total 1st - 3rd graders'
from author
join grade on author.GradeId = Grade.Id
where grade.Name = '3rd Grade' or grade.Name = '2nd Grade' or grade.Name = '1st Grade' 

-- What is the total number of poems written by fourth graders?
select count (Poem.Id) as 'poems written by 4th graders'
from Poem
join Author on poem.AuthorId = Author.Id
where Author.GradeId = 4;

-- How many poems are there per grade?
select g.Name, Count(p.Id) as 'NumPoems'
from Poem P 
join author a on a.id = p.AuthorId
join grade g on g.id = a.GradeId
group by g.Name;

-- How many authors are in each grade? (Order your results by grade starting with 1st Grade)
select g.name, count(a.Id) as 'TotalAuths'
from author a
join grade g on g.id = a.gradeid
group by g.name

-- What is the title of the poem that has the most words?
select top (1) p.Title
from Poem p
order by WordCount desc;

-- Which author(s) have the most poems? (Remember authors can have the same name.)
select a.Id, a.Name, count (p.AuthorId) as 'TotalPoemsWritten'
from author a
join poem p on a.Id = p.AuthorId
group by a.Id, a.Name, p.AuthorId
order by 'TotalPoemsWritten' desc;

-- How many poems have an emotion of sadness?
select count(p.Id)
from PoemEmotion pe
join emotion e on e.Id = pe.EmotionId
join poem p on p.Id = pe.PoemId
where e.Name = 'Sadness';

-- How many poems are not associated with any emotion?
select count(Poem.Id)
from Poem
left join PoemEmotion pe on pe.PoemId = Poem.Id
where pe.EmotionId is null

-- Which emotion is associated with the least number of poems? (anger)
select count (p.Id) as 'PoemsByEmotion', e.Name
from Poem p
join PoemEmotion pe on pe.PoemId = p.Id
join emotion e on e.Id = pe.EmotionId
group by e.Name
order by 'PoemsByEmotion' asc;

-- Which grade has the largest number of poems with an emotion of joy?
select count (p.Id) as 'PoemsByEmotion', e.Name, g.Name
from Poem p
join PoemEmotion pe on pe.PoemId = p.Id
join emotion e on e.Id = pe.EmotionId and e.Name = 'Joy'
join author a on p.AuthorId = a.Id
join grade g on g.Id = a.GradeId
group by e.Name, g.Name
order by 'PoemsByEmotion' desc;

-- Which gender has the least number of poems with an emotion of fear?
select count (p.Id) as 'PoemsByEmotion', e.Name, g.Name
from Poem p
join PoemEmotion pe on pe.PoemId = p.Id
join emotion e on e.Id = pe.EmotionId and e.Name = 'Fear'
join author a on p.AuthorId = a.Id
join gender g on g.Id = a.GenderId
group by e.Name, g.Name
order by 'PoemsByEmotion' asc;

