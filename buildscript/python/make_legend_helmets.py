from string import Template
from buildscript.python.helmet import Templates, Defs, cleanupDirs
from PIL import Image
from buildscript.python.crop import CropTool
import re, os, argparse
from pathlib import Path


def checkForIcon(path, iconpath, variants):
    dirpath = os.path.join(path, "gfx", "ui", "items", "legend_helmets")
    parts = iconpath.split("/")

    for p in parts:
        dirpath = os.path.join(dirpath, p)

    if len(variants) == 0:
        if not os.path.exists(dirpath + ".png"):
            print("Missing " + dirpath)
            return True
        return False

    has_missing = False
    for v in variants:
        variant = str(v)
        if v < 10:
            variant = "0" + variant
        if not os.path.exists(dirpath + "_" + variant + ".png"):
            print("Missing " + dirpath + "_" + variant)
            has_missing = True

    return has_missing


def makeSheet(path, num):
    dirpath = os.path.join(path, "unpacked", "legend_helmets", "" + str(num))
    if not os.path.exists(dirpath):
        os.makedirs(dirpath)

    filepath = os.path.join(dirpath, "metadata.xml")
    F = open(filepath, "w")
    F.write('<brush name="gfx/legend_helmets_' + str(num) + '.png" version="17">\n')
    return F


def makeBrushes(path):
    cleanupDirs(os.path.join(path, "unpacked", "legend_helmets"))
    helmetDir = os.path.join(path, "unpacked", "legend_helmets", "entity")
    fileCount = 0
    imageCount = 0
    F = makeSheet(path, fileCount)

    L = Templates.BLayer
    for d in Defs.layers:
        # ratio = 0
        # if d["stam"] < -1 and d["layer"] == "helm":
        #     ratio = (d["con"] * 1.0) / (-1.0 * d["stam"])
        #     print("{} {} : {}".format(d["name"], d["con"], ratio))
        R = L
        names = [d["name"]]
        if "min" in d:
            names = []
            for i in range(d["min"], d["max"] + 1):
                ind = "0" + str(i) if i < 10 else str(i)
                names.append(d["name"] + "_" + ind)

        for t in R:
            for name in names:
                name_path, damaged_path, dead_path, _dir = Templates.get_sprites(name)
                c_name_path, c_damaged_path, c_dead_path, c_dir = Templates.get_cropped_sprites(
                    name
                )

                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, name_path)),
                    os.path.abspath(os.path.join(helmetDir, c_name_path)),
                )
                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, damaged_path)),
                    os.path.abspath(os.path.join(helmetDir, c_damaged_path)),
                )
                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, dead_path)),
                    os.path.abspath(os.path.join(helmetDir, c_dead_path)),
                )
                cardinals = Templates.Cardinals

                opts = dict(
                    name="legendhelms_" + name,
                    damaged="legendhelms_" + name + "_damaged",
                    dead="legendhelms_" + name + "_dead",
                    name_path=c_name_path,
                    damaged_path=c_damaged_path,
                    dead_path=c_dead_path,
                    name_cardinals=Templates.calculate_cardinals(
                        cardinals[0],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, name_path))),
                    ),
                    damaged_cardinals=Templates.calculate_cardinals(
                        cardinals[1],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, damaged_path))),
                    ),
                    dead_cardinals=Templates.calculate_cardinals(
                        cardinals[2],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, dead_path))),
                    ),
                )
                #                 print(calculateCropArea(os.path.abspath(os.path.join(helmetDir, name + ".png"))))

                s = Template(t)
                text = s.substitute(opts)
                # Only replace forward slashes in img paths, not in "/>" endings
                text = re.sub(
                    r'img="([^"]*)"', lambda m: f'img="{m.group(1).replace("/", chr(92))}"', text
                )
                F.write(text)
                imageCount += 1
                if imageCount > 1600:
                    F.write("</brush>\n")
                    F.close()
                    imageCount = 0
                    fileCount += 1
                    F = makeSheet(path, fileCount)

    for d in Defs.brush_only_layers:
        R = L
        names = [d["name"]]
        if "min" in d:
            names = []
            for i in range(d["min"], d["max"] + 1):
                ind = "0" + str(i) if i < 10 else str(i)
                names.append(d["name"] + "_" + ind)

        for t in R:
            for name in names:
                name_path, damaged_path, dead_path, _dir = Templates.get_sprites(name)
                c_name_path, c_damaged_path, c_dead_path, c_dir = Templates.get_cropped_sprites(
                    name
                )

                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, name_path)),
                    os.path.abspath(os.path.join(helmetDir, c_name_path)),
                )
                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, damaged_path)),
                    os.path.abspath(os.path.join(helmetDir, c_damaged_path)),
                )
                CropTool.crop(
                    os.path.abspath(os.path.join(helmetDir, dead_path)),
                    os.path.abspath(os.path.join(helmetDir, c_dead_path)),
                )
                cardinals = Templates.Cardinals

                opts = dict(
                    name="legendhelms_" + name,
                    name_path=c_name_path,
                    damaged_path=c_damaged_path,
                    dead_path=c_dead_path,
                    name_cardinals=Templates.calculate_cardinals(
                        cardinals[0],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, name_path))),
                    ),
                    damaged_cardinals=Templates.calculate_cardinals(
                        cardinals[1],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, damaged_path))),
                    ),
                    dead_cardinals=Templates.calculate_cardinals(
                        cardinals[2],
                        CropTool.getBounds(os.path.abspath(os.path.join(helmetDir, dead_path))),
                    ),
                )
                s = Template(t)
                text = s.substitute(opts)
                # Only replace forward slashes in img paths, not in "/>" endings
                text = re.sub(
                    r'img="([^"]*)"', lambda m: f'img="{m.group(1).replace("/", chr(92))}"', text
                )
                F.write(text)
                imageCount += 1
                if imageCount > 1600:
                    F.write("</brush>\n")
                    F.close()
                    imageCount = 0
                    fileCount += 1
                    F = makeSheet(path, fileCount)

    F.write("</brush>\n")
    F.close()


def generate_legend_helmets(base_path):
    path = str(base_path)  # Convert Path to string for compatibility

    has_missing = False
    for d in Defs.layers:

        layer = d["layer"]

        lower = "false"

        temp = Templates.Layer
        if layer == "hood":
            temp = Templates.BaseLayer
            if "named" in d:
                temp = Templates.BaseNamedLayer
        elif "named" in d:
            temp = Templates.NamedLayer

        if "lower" in d:
            lower = "true"

        fname = "legend_helmet_" + d["name"]

        # print('"' + layer + '/' + fname + '",')
        # continue

        dirpath = os.path.join(path, "helmet_scripts", layer)
        if not os.path.exists(dirpath):
            os.makedirs(dirpath)

        filepath = os.path.join(dirpath, fname + ".nut")
        F = open(filepath, "w")
        variants = []
        for x in range(d["max"]):
            variants.append(x + 1)

        impactsound = "::Const.Sound.ArmorLeatherImpact"
        invsound = "::Const.Sound.ArmorLeatherImpact"
        if d["invSound"] == "cloth":
            invsound = "::Const.Sound.ClothEquip"
        elif d["invSound"] == "chain":
            invsound = "::Const.Sound.ArmorChainmailImpact"
        elif d["invSound"] == "plate":
            invsound = "::Const.Sound.ArmorHalfplateImpact"
        elif d["invSound"] == "bone":
            invsound = "::Const.Sound.ArmorBoneImpact"

        if d["impactSound"] == "chain":
            impactsound = "::Const.Sound.ArmorChainmailImpact"
        elif d["impactSound"] == "plate":
            impactsound = "::Const.Sound.ArmorHalfplateImpact"
        elif d["impactSound"] == "bone":
            impactsound = "::Const.Sound.ArmorBoneImpact"

        title = d["title"]
        desc = d["desc"]
        adesc = d["adesc"]

        has_missing = has_missing or checkForIcon(path, "inventory_" + d["name"], variants)

        itemType = "this.m.ItemType"
        if "itemType" in d:
            itemType += " | " + d["itemType"]

        opts = dict(
            test="true",
            name=fname,
            title=title,
            desc=desc,
            adesc=adesc,
            condition=d["con"],
            value=d["value"],
            stamina=d["stam"],
            vision=d["vis"],
            id="armor.head." + fname,
            variants=variants,
            layer=layer,
            type=d["layer"].capitalize(),
            brush="legendhelms_" + d["name"],
            icon="inventory_" + d["name"],
            impactSound=impactsound,
            invSound=invsound,
            lower=lower,
            hair=d["hair"],
            beard=d["beard"],
            names=d["names"] if "names" in d else [],
            rminViz=d["rminViz"] if "rminViz" in d else 0,
            rmaxViz=d["rmaxViz"] if "rmaxViz" in d else 0,
            rminStam=d["rminStam"] if "rminStam" in d else 0,
            rmaxStam=d["rmaxStam"] if "rmaxStam" in d else 0,
            rminCond=d["rminCond"] if "rminCond" in d else 0,
            rmaxCond=d["rmaxCond"] if "rmaxCond" in d else 0,
            itemType=itemType,
        )
        s = Template(temp)
        text = s.substitute(opts)
        F.write(text.strip())
        F.close()

    makeBrushes(path)

    if has_missing:
        raise ValueError("Missing gfx icons")


def main():
    parser = argparse.ArgumentParser(description="Legends helmet brushes generator.")
    parser.add_argument("path", type=str, help="The base directory path")
    args = parser.parse_args()

    base_path = Path(args.path)
    generate_legend_helmets(base_path)


if __name__ == "__main__":
    main()