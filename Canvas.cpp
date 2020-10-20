/*
* Canvas.cpp, 10/4/2020 10:54 PM
*/

#include <d2d1.h>

class Canvas {
public:

    ID2D1Factory* d2d_factory = nullptr;
    ID2D1DCRenderTarget* render = nullptr;

    Canvas(HWND hwnd) {
        D2D1CreateFactory(D2D1_FACTORY_TYPE_SINGLE_THREADED, &d2d_factory);
        D2D1_RENDER_TARGET_PROPERTIES props = D2D1::RenderTargetProperties(
            D2D1_RENDER_TARGET_TYPE_DEFAULT,
            D2D1::PixelFormat(DXGI_FORMAT_B8G8R8A8_UNORM, D2D1_ALPHA_MODE_IGNORE),
            0, 0,
            D2D1_RENDER_TARGET_USAGE_NONE,
            D2D1_FEATURE_LEVEL_DEFAULT);
        d2d_factory->CreateDCRenderTarget(&props, &render);

        RECT r;
        HDC dc = GetDC(hwnd);
        GetClientRect(hwnd, &r);
        render->BindDC(dc, &r);
    }

    virtual ~Canvas() {
        render->Release();
        d2d_factory->Release();
    }

    void begin_draw() {
        render->BeginDraw();
    }

    void end_draw() {
        render->EndDraw();
    }

    void clear() {
        render->Clear();
    }

    void push_rectangle_clip(float x0, float y0, float x1, float y1) {
        render->PushAxisAlignedClip({x0, y0, x1, y1}, D2D1_ANTIALIAS_MODE_PER_PRIMITIVE);
    }

    void pop_rectangle_clip() {
        render->PopAxisAlignedClip();
    }

    void draw_line(float x0, float y0, float x1, float y1, int rgb) {
        ID2D1SolidColorBrush* brush;
        render->CreateSolidColorBrush(D2D1::ColorF(rgb), &brush);
        render->DrawLine({x0, y0}, {x1, y1}, brush);
        brush->Release();
    }

    void draw_rect(float x0, float y0, float x1, float y1, int rgb, float width = 1.0) {
        ID2D1SolidColorBrush* brush;
        render->CreateSolidColorBrush(D2D1::ColorF(rgb), &brush);
        render->DrawRectangle({x0, y0, x1, y1}, brush, width);
        brush->Release();
    }

    void fill_rect(float x0, float y0, float x1, float y1, int rgb) {
        ID2D1SolidColorBrush* brush;
        render->CreateSolidColorBrush(D2D1::ColorF(rgb), &brush);
        render->FillRectangle({x0, y0, x1, y1}, brush);
        brush->Release();
    }
};
