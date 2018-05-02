#!/usr/bin/env python2

import sys
import re
import pygments
import pygments.formatters
import hoedown as hd

reload(sys)
sys.setdefaultencoding("utf-8")

exts = hd.EXT_NO_INTRA_EMPHASIS | hd.EXT_TABLES | hd.EXT_FENCED_CODE | hd.EXT_FOOTNOTES

class Renderer(hd.HtmlRenderer, hd.SmartyPants):
    formatter = pygments.formatters.HtmlFormatter()

    def block_code(self, text, lang):
        try:
            lexer = pygments.lexers.get_lexer_by_name(lang)
        except ValueError:
            lexer = pygments.lexers.TextLexer()

        return pygments.highlight(text, lexer, self.formatter)

mdrender = hd.Markdown(Renderer(0), exts).render

if __name__ == "__main__":
    sys.stdout.write(mdrender(sys.stdin.read()))
