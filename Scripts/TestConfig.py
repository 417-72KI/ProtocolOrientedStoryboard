#!/usr/bin/env python3

from Config import build, getFiles, dict_merge, dump

def main(args):
    origin_data = build(getFiles(args.origin_src_directory, args.env))
    test_data = build(getFiles(args.src_directory, None))

    data = dict_merge(origin_data, test_data)

    dump(data, args.output_file)

def parse():
    from argparse import ArgumentParser, FileType
    argparser = ArgumentParser()
    argparser.add_argument('-e', '--env', default='development')
    argparser.add_argument('-o', '--origin-src-directory')
    argparser.add_argument('-d', '--output-file',
                        nargs='?',
                        type=FileType('wb'),
                        default='./TestConfig.plist')
    argparser.add_argument('src_directory')
    return argparser.parse_args()

if __name__ == "__main__":
    main(parse())
