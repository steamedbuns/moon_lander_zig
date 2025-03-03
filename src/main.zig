const rl = @import("raylib");
const MAX_BUILDINGS = 100;

pub fn main() anyerror!void {

    // Initialization
    const screenWidth = 1360;
    const screenHeight = 960;

    rl.initWindow(screenWidth, screenHeight, "moon-lander-zig");
    defer rl.closeWindow();

    rl.setWindowPosition(100, 100);
    rl.setTargetFPS(60);

    // Game setup
    var lander = rl.Rectangle{ .height = 40.0, .width = 40.0, .x = screenWidth / 2.0, .y = 790.0 };
    var buildings: [MAX_BUILDINGS]rl.Rectangle = undefined;
    var buildingColors: [MAX_BUILDINGS]rl.Color = undefined;

    var spacing: f32 = 0.0;
    for (0..MAX_BUILDINGS) |index| {
        const height: f32 = @as(f32, @floatFromInt(rl.getRandomValue(100, 800)));
        const width: f32 = @as(f32, @floatFromInt(rl.getRandomValue(50, 200)));
        buildings[index] = rl.Rectangle{ .width = width, .height = height, .y = @as(f32, screenHeight) - 130.0 - height, .x = -6000.0 + spacing };

        spacing += width;

        buildingColors[index] = rl.Color{ .r = @intCast(rl.getRandomValue(200, 240)), .g = @intCast(rl.getRandomValue(200, 240)), .b = @intCast(rl.getRandomValue(200, 250)), .a = @intCast(255) };
    }

    var camera = rl.Camera2D{ .target = rl.Vector2{ .x = lander.x + 20.0, .y = lander.y + 20.0 }, .offset = rl.Vector2{ .x = screenWidth / 2.0, .y = screenHeight / 2.0 }, .rotation = 0.0, .zoom = 1.0 };

    const screenRect = rl.Rectangle{ .x = 0, .y = 0, .width = screenWidth, .height = screenHeight };

    while (!rl.windowShouldClose()) {
        // Update game state
        if (rl.isKeyDown(rl.KeyboardKey.right)) {
            lander.x += 2;
        } else if (rl.isKeyDown(rl.KeyboardKey.left)) {
            lander.x -= 2;
        }

        camera.target = rl.Vector2{ .x = lander.x + 20, .y = lander.y + 20 };

        camera.zoom += rl.getMouseWheelMove() * 0.05;
        if (camera.zoom > 3.0) {
            camera.zoom = 3.0;
        } else if (camera.zoom < 0.1) {
            camera.zoom = 0.1;
        }

        if (rl.isKeyPressed(rl.KeyboardKey.r)) {
            camera.zoom = 1.0;
        }

        // Render
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);
        {
            rl.beginMode2D(camera);
            defer rl.endMode2D();

            rl.drawRectangle(-6000, 830, 13000, 8000, rl.Color.dark_gray);

            for (0..MAX_BUILDINGS) |index| {
                rl.drawRectangleRec(buildings[index], buildingColors[index]);
            }

            rl.drawRectangleRec(lander, rl.Color.red);
        }
        rl.drawRectangleLinesEx(screenRect, 5.0, rl.Color.red);
    }
}
