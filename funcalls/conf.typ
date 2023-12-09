#let conf(doc) = {

    let copyright_message = "Copyright © The Ferrocene Developers. Contents released under the MIT or Apache 2.0 license."

    set page(
        footer: copyright_message,
    )

    show heading.where(level: 1): content => [
        #pagebreak(weak: true)
        #set block(below: 1em)
        #content
    ]

    show heading.where(level: 2): content => [
        #set block(above: 2em, below: 1em)
        #content
    ]

    show heading.where(level: 3): content => [
        #set block(below: 1em)
        #content
    ]

    show link: set text(blue)

    set heading(numbering: "1.1.1")

    show "%SKIPPING%": name => text(green)[(((...)))]

    doc

}
