//= require_self


function findWithAttr(array, attr, value) {
    var muted = true;
    if(!muted) console.log('\t\t\tfindWithAttr - array', array);
    if(!muted) console.log('\t\t\tfindWithAttr - attr', attr);
    if(!muted) console.log('\t\t\tfindWithAttr - value', value);
    if (angular.isArray(array)) {
        for (var i = 0; i < array.length; i++) {
            if(!muted) console.log('\t\t\t\tfindWithAttr - array['+i+']['+attr+']', array[i][attr]);
            if (array[i][attr] === value) {
                return i+1;
            }
        }
    }
}

function indexOfAll(array, value) {
    var indexArr = [];
    if (angular.isArray(array)) {
        for (var i = 0; i < array.length; i++) {
            if (array[i] === value) indexArr.push(i);
        }
    }
    return indexArr;
}

