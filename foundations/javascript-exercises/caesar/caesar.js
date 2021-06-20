const caesar = function(message, shift) {
    const messageArray = [...message];
    let shiftedArrary = messageArray.map(character  =>  {
        const charCode = character.charCodeAt(0);
        if (charCode >= 97 && charCode <= 122) {
             String.fromCharCode(charCode + shift);
        }  
        else if (charCode >=65 && charCode <= 90) {
             String.fromCharCode(charCode + shift);

        }
    });
}   


module.exports = caesar
