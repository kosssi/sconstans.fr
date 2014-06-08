module.exports = function(grunt) {
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-gh-pages');

    var filesLess = {};

    // Configuration
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        less: {
            bundles: {
                files: filesLess
            }
        },

        cssmin: {
            minify: {
                expand: true,
                src: ['built/styles.css'],
                ext: '.min.css'
            }
        },

        concat: {
            css: {
                src: [
                    'built/css/*.css'
                ],
                dest: 'built/styles.css'
            }
        },

        watch: {
            css: {
                files: ['src/less/*.less'],
                tasks: ['css']
            }
        },

        'gh-pages': {
            options: {
                base: '_site'
            },
            src: ['**']
        }
    });

    // Default task(s).
    grunt.registerTask('default', ['css']);
    grunt.registerTask('deploy', ['css', 'gh-pages']);
    grunt.registerTask('css', ['less:discovering', 'less', 'concat:css', 'cssmin']);
    grunt.registerTask('less:discovering', 'This is a function', function() {
        // LESS Files management
        // Source LESS files are located inside : bundles/[bundle]/less/
        // Destination CSS files are located inside : built/[bundle]/css/
        var mappingFileLess = grunt.file.expandMapping(
            ['*.less'],
            'built/css/', {
                cwd: 'src/less/',
                rename: function(dest, matchedSrcPath, options) {
                    return dest + matchedSrcPath.replace(/less/g, 'css');
                }
            });

        grunt.util._.each(mappingFileLess, function(value) {
            // Why value.src is an array ??
            filesLess[value.dest] = value.src[0];
        });
    });
};
