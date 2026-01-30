# Drawing App Feature

## Overview
A new drawing app has been added to Samu's Adventures, allowing children to freely draw and be creative.

## Features

### Canvas Drawing
- **Touch Drawing**: Users can draw freely on the canvas using their fingers or Apple Pencil
- **Smooth Lines**: Lines are rendered smoothly using SwiftUI Canvas for optimal performance
- **Real-time Drawing**: Drawing appears instantly as users move their finger/stylus

### Color Palette
The drawing app includes 10 vibrant colors:
- Black
- Red
- Blue
- Green
- Orange
- Purple
- Pink
- Yellow
- Brown
- Gray

### Brush Size Control
- Adjustable brush size from 2 to 20 pixels
- Slider control for easy adjustment
- Live preview of current brush size

### User Interface
- **Back Button**: Returns to the main menu
- **Clear Button**: Clears the entire canvas to start fresh
- **Color Picker**: Horizontally scrollable color palette
- **Brush Size Slider**: Controls the thickness of the drawing line

## Localization
The drawing app is fully localized in both English and Hungarian:
- English: "Drawing", "Back", "Clear", "Brush Size:"
- Hungarian: "Rajzolás", "Vissza", "Törlés", "Ecset méret:"

## Access
The drawing app can be accessed from the main menu by:
1. Tapping the hamburger menu (☰) in the top-left corner
2. Selecting "Drawing" / "Rajzolás" from the menu

## Technical Implementation
- **File**: `DrawingCanvasView.swift`
- **Framework**: SwiftUI with Canvas API
- **Gesture Handling**: DragGesture for smooth line drawing
- **State Management**: @State for managing drawing lines and UI state
- **Navigation**: Integrated into existing NavigationStack

## Code Structure

### DrawingLine
A struct representing a single drawn line:
```swift
struct DrawingLine {
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat
}
```

### DrawingCanvasView
Main view that provides:
- Canvas for drawing
- Color selection toolbar
- Brush size slider
- Clear and back buttons
