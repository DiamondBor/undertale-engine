return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 13,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 20,
  properties = {
    ["border"] = "undertale/ruins",
    ["light"] = true,
    ["music"] = "ruins",
    ["name"] = "Ruins - Test Room 2"
  },
  tilesets = {
    {
      name = "castle",
      firstgid = 1,
      filename = "../tilesets/castle.tsx",
      exportfilename = "../tilesets/castle.lua"
    },
    {
      name = "ruins4",
      firstgid = 41,
      filename = "../tilesets/ruins4.tsx"
    },
    {
      name = "ruins3",
      firstgid = 81,
      filename = "../tilesets/ruins3.tsx"
    },
    {
      name = "ruins1",
      firstgid = 153,
      filename = "../tilesets/ruins1.tsx"
    },
    {
      name = "objects",
      firstgid = 305,
      filename = "../tilesets/objects.tsx",
      exportfilename = "../tilesets/objects.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 13,
      id = 1,
      name = "tiles",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 70, 63, 64, 0, 0, 62, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 71,
        0, 0, 0, 56, 43, 44, 43, 43, 42, 43, 43, 43, 43, 43, 43, 43, 43, 43, 43, 54,
        0, 0, 0, 56, 43, 44, 43, 43, 42, 43, 43, 43, 43, 43, 43, 43, 43, 43, 43, 54,
        0, 0, 0, 56, 51, 52, 51, 51, 50, 51, 51, 51, 51, 51, 51, 51, 51, 51, 51, 54,
        0, 0, 0, 56, 57, 57, 89, 89, 115, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 54,
        303, 303, 303, 64, 57, 57, 89, 89, 89, 89, 106, 57, 57, 57, 57, 57, 57, 57, 57, 54,
        43, 43, 43, 44, 57, 57, 113, 89, 89, 89, 89, 115, 57, 57, 57, 57, 57, 57, 57, 54,
        43, 43, 43, 44, 57, 57, 57, 57, 108, 89, 89, 89, 89, 89, 89, 106, 57, 57, 57, 54,
        51, 51, 51, 52, 57, 57, 57, 57, 116, 89, 89, 89, 89, 89, 89, 114, 57, 57, 57, 54,
        57, 105, 89, 89, 89, 89, 89, 89, 89, 89, 89, 107, 57, 57, 57, 57, 57, 57, 57, 54,
        57, 113, 89, 89, 89, 89, 89, 89, 89, 89, 114, 57, 57, 57, 57, 57, 57, 57, 57, 54,
        47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 79,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 13,
      id = 2,
      name = "decal",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 313, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "collision",
      class = "",
      visible = true,
      opacity = 0.5,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 160,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 440,
          width = 760,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 160,
          width = 40,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 320,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 120,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 120,
          width = 440,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 80,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 5,
          name = "spawn",
          type = "",
          shape = "point",
          x = 280,
          y = 220,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "entry",
          type = "",
          shape = "point",
          x = 80,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 6,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 540,
          y = 300,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "dummy_ut",
            ["lightencounter"] = "dummy"
          }
        },
        {
          id = 9,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 360,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "room1",
            ["marker"] = "entry"
          }
        },
        {
          id = 14,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 120,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "prelab",
            ["marker"] = "entry"
          }
        },
        {
          id = 17,
          name = "npc",
          type = "",
          shape = "point",
          x = 640,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "toriel",
            ["cutscene"] = "room1.toriel"
          }
        },
        {
          id = 18,
          name = "storagebox",
          type = "",
          shape = "rectangle",
          x = 700,
          y = 160,
          width = 41.3333,
          height = 42,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "lightsavepoint",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 160,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["advanced_menu"] = false,
            ["text1"] = "* Money"
          }
        }
      }
    }
  }
}
