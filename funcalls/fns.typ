#let dt(term_name) = [
    #text(blue, term_name)
    #label(term_name)
]

// Use like #t("trait")
#let t(term_name) = {
    link(label(term_name), text(blue, term_name))
}

// Use like #t2("trait")[traits]
// FIXME: this is sometimes leaving extra whitespace afterwards, eg with
//  #t2("trait")[traits].
// there is a space before the .
#let t2(term_name, body) = [
    #link(label(term_name), text(blue, body))
]

#let rubric(body) = {
    set block(above: 1.5em)
    text(weight:"bold", body)
}

#let std(body) = {
    // This would link to the stdlib docs.
    raw(body)
}

// We'd want some kind of custom processing for this, in particular
// interpreting the $$ markup.
#let syntax(body) = {
    body
}

#let editorial(body) = {
    text(green, body)
}

