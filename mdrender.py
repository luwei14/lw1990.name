#!/usr/bin/env python
#coding=utf-8

import sys
import re
import pygments
import pygments.formatters
import pygments.lexers
import hoedown as h
reload(sys)
sys.setdefaultencoding("utf-8")
exts = h.EXT_NO_INTRA_EMPHASIS | h.EXT_TABLES | h.EXT_FENCED_CODE | h.EXT_FOOTNOTES

class Renderer(h.HtmlRenderer, h.SmartyPants):
    formatter = pygments.formatters.HtmlFormatter()

    def block_code(self, text, lang):
        try:
            lexer = pygments.lexers.get_lexer_by_name(lang)
        except ValueError:
            lexer = pygments.lexers.TextLexer()
        return pygments.highlight(text, lexer, self.formatter)

mdrender = h.Markdown(Renderer(0), exts).render

if __name__ == "__main__":
    sys.stdout.write(mdrender(sys.stdin.read()))
