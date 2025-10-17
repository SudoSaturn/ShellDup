typedef struct BgimageUniforms {
    int image;
    int background;
    int tiled;
    int sizes;
    int positions;
} BgimageUniforms;

static inline void
get_uniform_locations_bgimage(int program, BgimageUniforms *ans) {
    ans->image = get_uniform_location(program, "image");
    ans->background = get_uniform_location(program, "background");
    ans->tiled = get_uniform_location(program, "tiled");
    ans->sizes = get_uniform_location(program, "sizes");
    ans->positions = get_uniform_location(program, "positions");
}

typedef struct BlitUniforms {
    int image;
    int src_rect;
    int dest_rect;
} BlitUniforms;

static inline void
get_uniform_locations_blit(int program, BlitUniforms *ans) {
    ans->image = get_uniform_location(program, "image");
    ans->src_rect = get_uniform_location(program, "src_rect");
    ans->dest_rect = get_uniform_location(program, "dest_rect");
}

typedef struct BorderUniforms {
    int colors;
    int background_opacity;
    int gamma_lut;
} BorderUniforms;

static inline void
get_uniform_locations_border(int program, BorderUniforms *ans) {
    ans->colors = get_uniform_location(program, "colors");
    ans->background_opacity = get_uniform_location(program, "background_opacity");
    ans->gamma_lut = get_uniform_location(program, "gamma_lut");
}

typedef struct CellUniforms {
    int text_contrast;
    int text_gamma_adjustment;
    int sprites;
    int gamma_lut;
    int draw_bg_bitfield;
    int sprite_decorations_map;
} CellUniforms;

static inline void
get_uniform_locations_cell(int program, CellUniforms *ans) {
    ans->text_contrast = get_uniform_location(program, "text_contrast");
    ans->text_gamma_adjustment = get_uniform_location(program, "text_gamma_adjustment");
    ans->sprites = get_uniform_location(program, "sprites");
    ans->gamma_lut = get_uniform_location(program, "gamma_lut");
    ans->draw_bg_bitfield = get_uniform_location(program, "draw_bg_bitfield");
    ans->sprite_decorations_map = get_uniform_location(program, "sprite_decorations_map");
}

typedef struct GraphicsUniforms {
    int image;
    int amask_fg;
    int amask_bg_premult;
    int extra_alpha;
    int src_rect;
    int dest_rect;
} GraphicsUniforms;

static inline void
get_uniform_locations_graphics(int program, GraphicsUniforms *ans) {
    ans->image = get_uniform_location(program, "image");
    ans->amask_fg = get_uniform_location(program, "amask_fg");
    ans->amask_bg_premult = get_uniform_location(program, "amask_bg_premult");
    ans->extra_alpha = get_uniform_location(program, "extra_alpha");
    ans->src_rect = get_uniform_location(program, "src_rect");
    ans->dest_rect = get_uniform_location(program, "dest_rect");
}

typedef struct Rounded_rectUniforms {
    int rect;
    int params;
    int color;
    int background_color;
} Rounded_rectUniforms;

static inline void
get_uniform_locations_rounded_rect(int program, Rounded_rectUniforms *ans) {
    ans->rect = get_uniform_location(program, "rect");
    ans->params = get_uniform_location(program, "params");
    ans->color = get_uniform_location(program, "color");
    ans->background_color = get_uniform_location(program, "background_color");
}

typedef struct TintUniforms {
    int tint_color;
    int edges;
} TintUniforms;

static inline void
get_uniform_locations_tint(int program, TintUniforms *ans) {
    ans->tint_color = get_uniform_location(program, "tint_color");
    ans->edges = get_uniform_location(program, "edges");
}

typedef struct TrailUniforms {
    int cursor_edge_x;
    int cursor_edge_y;
    int trail_color;
    int trail_opacity;
    int x_coords;
    int y_coords;
} TrailUniforms;

static inline void
get_uniform_locations_trail(int program, TrailUniforms *ans) {
    ans->cursor_edge_x = get_uniform_location(program, "cursor_edge_x");
    ans->cursor_edge_y = get_uniform_location(program, "cursor_edge_y");
    ans->trail_color = get_uniform_location(program, "trail_color");
    ans->trail_opacity = get_uniform_location(program, "trail_opacity");
    ans->x_coords = get_uniform_location(program, "x_coords");
    ans->y_coords = get_uniform_location(program, "y_coords");
}
