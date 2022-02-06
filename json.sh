function json {
    if [[ $# -lt 1 ]]; then
        echo "USAGE: json JAVASCRIPT [...ARGS]"
        echo
        echo "Evaluates JAVASCRIPT and serializes it to JSON."
        echo
        echo "ARGS will be available as the JavaScript variables _1, _2, _3," \
             'etc. Ex: `json "{a: _1}" b` is equivalent to `json "{a: b}"`.'
        echo
        echo "All non-array variables (regardless of export status) will be" \
             "available as JavaScript variables of the same name. Ex:" \
             '`json "{a: PATH}"` will print the value of your PATH env' \
             "variable."
        return 1
    fi

    (
        for i in $(compgen -v); do
            export "$i"
        done

        node -- - "$@" <<< "
            for (let i = 3; i < process.argv.length; ++i) {
                global['_' + (i - 2)] = process.argv[i];
            }

            for(const [k, v] of Object.entries(process.env)) {
                if (! Object.prototype.hasOwnProperty.call(global, k)) {
                    global[k] = v;
                }
            }

            console.log(JSON.stringify(eval('(' + process.argv[2] + ')')));
        "
    )
}
