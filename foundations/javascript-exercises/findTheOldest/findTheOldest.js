const people = [
    {
      name: 'Carly',
      yearOfBirth: 1066,
   
    },
    {
      name: 'Ray',
      yearOfBirth: 1962,
      yearOfDeath: 2011
    },
    {
      name: 'Jane',
      yearOfBirth: 1912,
      yearOfDeath: 1941
    },
  ]
let findTheOldest = function(people) {
    let age = (person) => (person.yearOfDeath === undefined) ? livingAge(person) : deadAge(person);  
    let livingAge = (alive) => new Date().getFullYear() - alive.yearOfBirth;
    let deadAge = (dead) => dead.yearOfDeath - dead.yearOfBirth;
    
    let oldest = people.sort((a, b) => age(a) > age(b) ? -1 : 1);

    return oldest[0]; 
}

module.exports = findTheOldest

console.log(findTheOldest(people));