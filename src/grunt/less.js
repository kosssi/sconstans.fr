module.exports = {
  bundles: {
    files: function() {
        var filesLess = [],
            mappingFileLess = grunt.file.expandMapping(
            ['src/less/*.less'],
            'built/css', {
                cwd: 'built/css/',
                rename: function(dest, matchedSrcPath, options) {
                    return dest + matchedSrcPath.replace(/less/g, 'css');
                }
            });

        grunt.util._.each(mappingFileLess, function(value) {
            // Why value.src is an array ??
            filesLess[value.dest] = value.src[0];
        });

        return filesLess;
    }
  }
};
