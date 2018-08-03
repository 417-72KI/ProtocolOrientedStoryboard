#!/usr/bin/env python3

from functools import reduce
import os.path

def main(args):
    files = getFiles(args.src_directory, args.env)
    data = build(files)
    dump(data, args.output_file)

def getFiles(directory, env):
    import glob
    files = glob.glob("{}/*.yml".format(directory))
    if env is not None and env != "":
        env_file = "{}/env/{}.yml".format(directory, env)
        if not os.path.exists(env_file):
            raise Exception("{} not exist".format(env_file))
        files.append(env_file)
    return files

def build(files):
    data = [load(f) for f in files]
    if not data:
        return {}
    return reduce(lambda a, b: dict_merge(a, b), data)

def load(src):
    import yaml
    with open(src, encoding='utf-8') as d:
        return yaml.load(d)

def dump(data, dest):
    import plistlib
    try:
        if data is None:
            data = {}
        plistlib.dump(data, dest)
    except Exception as e:
        import os
        os.remove(dest)
        raise(e)

def dict_merge(a, b):
    from copy import deepcopy
    if not isinstance(b, dict):
        return b
    result = deepcopy(a)
    for k, v in b.items():
        if k in result and isinstance(result[k], dict):
            result[k] = dict_merge(result[k], v)
        else:
            result[k] = deepcopy(v)
    return result

def parse():
    from argparse import ArgumentParser, FileType
    argparser = ArgumentParser()
    argparser.add_argument('-e', '--env')
    argparser.add_argument('-o', '--output-file',
                        nargs='?',
                        type=FileType('wb'),
                        default='./Config.plist')
    argparser.add_argument('src_directory')
    return argparser.parse_args()

if __name__ == "__main__":
    main(parse())
