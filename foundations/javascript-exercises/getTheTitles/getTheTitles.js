const getTheTitles = function(obj) {
    let titles = obj.map(book => book.title);
    return titles;
}

module.exports = getTheTitles;
