<script setup lang="ts">
import { ref, watch, onMounted, onUnmounted, nextTick } from 'vue'
import { useDiagramViewer } from './useDiagramViewer'

const { isOpen, currentDiagram, close } = useDiagramViewer()

const scale = ref(1)
const translateX = ref(0)
const translateY = ref(0)
const isDragging = ref(false)
const hasMoved = ref(false)
let dragStartX = 0
let dragStartY = 0
let initialTranslateX = 0
let initialTranslateY = 0

function resetTransform() {
  scale.value = 1
  translateX.value = 0
  translateY.value = 0
}

function zoomIn() {
  scale.value = Math.min(6, Math.round((scale.value + 0.25) * 100) / 100)
}

function zoomOut() {
  scale.value = Math.max(0.2, Math.round((scale.value - 0.25) * 100) / 100)
}

function onWheel(e: WheelEvent) {
  e.preventDefault()
  const delta = e.deltaY > 0 ? -0.15 : 0.15
  const newScale = Math.min(6, Math.max(0.2, scale.value + delta))
  scale.value = Math.round(newScale * 100) / 100
}

function startDrag(e: MouseEvent) {
  // Only drag on left click
  if (e.button !== 0) return
  isDragging.value = true
  hasMoved.value = false
  dragStartX = e.clientX
  dragStartY = e.clientY
  initialTranslateX = translateX.value
  initialTranslateY = translateY.value
}

function onDrag(e: MouseEvent) {
  if (!isDragging.value) return
  const dx = e.clientX - dragStartX
  const dy = e.clientY - dragStartY
  if (Math.abs(dx) > 3 || Math.abs(dy) > 3) {
    hasMoved.value = true
  }
  translateX.value = initialTranslateX + dx
  translateY.value = initialTranslateY + dy
}

function stopDrag() {
  isDragging.value = false
}

// Touch support
let initialPinchDistance = 0
let initialPinchScale = 1

function onTouchStart(e: TouchEvent) {
  if (e.touches.length === 1) {
    isDragging.value = true
    dragStartX = e.touches[0].clientX
    dragStartY = e.touches[0].clientY
    initialTranslateX = translateX.value
    initialTranslateY = translateY.value
  } else if (e.touches.length === 2) {
    isDragging.value = false
    initialPinchDistance = Math.hypot(
      e.touches[0].clientX - e.touches[1].clientX,
      e.touches[0].clientY - e.touches[1].clientY
    )
    initialPinchScale = scale.value
  }
}

function onTouchMove(e: TouchEvent) {
  if (e.touches.length === 1 && isDragging.value) {
    const dx = e.touches[0].clientX - dragStartX
    const dy = e.touches[0].clientY - dragStartY
    translateX.value = initialTranslateX + dx
    translateY.value = initialTranslateY + dy
  } else if (e.touches.length === 2 && initialPinchDistance > 0) {
    const currentDistance = Math.hypot(
      e.touches[0].clientX - e.touches[1].clientX,
      e.touches[0].clientY - e.touches[1].clientY
    )
    const factor = currentDistance / initialPinchDistance
    scale.value = Math.min(6, Math.max(0.2, Math.round(initialPinchScale * factor * 100) / 100))
  }
}

function onTouchEnd() {
  isDragging.value = false
  initialPinchDistance = 0
}

function handleKeydown(e: KeyboardEvent) {
  if (!isOpen.value) return
  if (e.key === 'Escape') {
    close()
  } else if (e.key === '+' || e.key === '=') {
    zoomIn()
  } else if (e.key === '-' || e.key === '_') {
    zoomOut()
  } else if (e.key === '0' || e.key === 'r' || e.key === 'R') {
    resetTransform()
  }
}

watch(isOpen, (open) => {
  if (open) {
    resetTransform()
    nextTick(() => {
      window.addEventListener('keydown', handleKeydown)
    })
  } else {
    window.removeEventListener('keydown', handleKeydown)
  }
})

onMounted(() => {
  if (typeof window !== 'undefined') {
    window.addEventListener('keydown', handleKeydown)
  }
})

onUnmounted(() => {
  if (typeof window !== 'undefined') {
    window.removeEventListener('keydown', handleKeydown)
  }
})
</script>

<template>
  <Teleport to="body">
    <Transition name="diagram-fade">
      <div
        v-if="isOpen && currentDiagram"
        class="diagram-overlay"
        @wheel="onWheel"
        @mousedown="startDrag"
        @mousemove="onDrag"
        @mouseup="stopDrag"
        @mouseleave="stopDrag"
        @touchstart.passive="onTouchStart"
        @touchmove.passive="onTouchMove"
        @touchend="onTouchEnd"
      >
        <!-- Top Toolbar -->
        <header class="diagram-toolbar" @mousedown.stop>
          <div class="toolbar-title">
            <span class="title-badge">Diagram</span>
            <span class="title-text">{{ currentDiagram.title || 'Interactive Diagram Viewer' }}</span>
          </div>

          <div class="toolbar-actions">
            <button
              class="toolbar-btn"
              type="button"
              title="Zoom out (-)"
              aria-label="Zoom out"
              @click="zoomOut"
            >
              <svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor">
                <path d="M5 11h14v2H5z" />
              </svg>
            </button>

            <button
              class="toolbar-btn zoom-level-btn"
              type="button"
              title="Click to reset zoom"
              aria-label="Reset zoom level"
              @click="resetTransform"
            >
              {{ Math.round(scale * 100) }}%
            </button>

            <button
              class="toolbar-btn"
              type="button"
              title="Zoom in (+)"
              aria-label="Zoom in"
              @click="zoomIn"
            >
              <svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor">
                <path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z" />
              </svg>
            </button>

            <div class="toolbar-divider" />

            <button
              class="toolbar-btn reset-btn"
              type="button"
              title="Reset view (0 / R)"
              aria-label="Reset diagram view"
              @click="resetTransform"
            >
              <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor">
                <path d="M12 5V1L7 6l5 5V7c3.31 0 6 2.69 6 6s-2.69 6-6 6-6-2.69-6-6H4c0 4.42 3.58 8 8 8s8-3.58 8-8-3.58-8-8-8z" />
              </svg>
              <span>Fit</span>
            </button>

            <button
              class="toolbar-btn close-btn"
              type="button"
              title="Close viewer (Escape)"
              aria-label="Close diagram viewer"
              @click="close"
            >
              <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
                <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z" />
              </svg>
              <span class="close-label">Close</span>
            </button>
          </div>
        </header>

        <!-- Canvas Container -->
        <div class="diagram-canvas" :class="{ dragging: isDragging }">
          <div
            class="diagram-viewport"
            :style="{
              transform: `translate3d(${translateX}px, ${translateY}px, 0) scale(${scale})`,
              transition: isDragging ? 'none' : 'transform 0.12s cubic-bezier(0.2, 0, 0, 1)'
            }"
          >
            <!-- Render SVG content -->
            <div
              v-if="currentDiagram.type === 'svg'"
              class="diagram-svg-wrapper"
              v-html="currentDiagram.content"
            />
            <!-- Render Image content -->
            <img
              v-else-if="currentDiagram.type === 'image'"
              :src="currentDiagram.content"
              :alt="currentDiagram.title || 'Diagram'"
              class="diagram-img"
              draggable="false"
            />
          </div>
        </div>

        <!-- Help instructions at bottom -->
        <footer class="diagram-hint" @mousedown.stop>
          <span>Scroll to zoom</span>
          <span class="dot">•</span>
          <span>Click & drag to pan</span>
          <span class="dot">•</span>
          <span>Press <strong>Esc</strong> to close</span>
        </footer>
      </div>
    </Transition>
  </Teleport>
</template>

<style scoped>
.diagram-overlay {
  position: fixed;
  inset: 0;
  z-index: 99999;
  display: flex;
  flex-direction: column;
  background: rgba(11, 19, 36, 0.94);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  user-select: none;
  overflow: hidden;
}

/* Toolbar */
.diagram-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.85rem 1.5rem;
  background: rgba(18, 28, 48, 0.85);
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.35);
  z-index: 10;
}

.toolbar-title {
  display: flex;
  align-items: center;
  gap: 0.65rem;
  color: #f1f5f9;
  font-size: 0.95rem;
  font-weight: 500;
  min-width: 0;
}

.title-badge {
  display: inline-flex;
  align-items: center;
  padding: 0.15rem 0.5rem;
  font-size: 0.72rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.04em;
  background: rgba(0, 120, 212, 0.25);
  color: #60a5fa;
  border: 1px solid rgba(96, 165, 250, 0.35);
  border-radius: 4px;
}

.title-text {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.toolbar-actions {
  display: flex;
  align-items: center;
  gap: 0.4rem;
}

.toolbar-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.35rem;
  padding: 0.45rem 0.65rem;
  background: rgba(255, 255, 255, 0.06);
  border: 1px solid rgba(255, 255, 255, 0.12);
  border-radius: 6px;
  color: #e2e8f0;
  font-size: 0.85rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.15s ease;
}

.toolbar-btn:hover {
  background: rgba(255, 255, 255, 0.14);
  color: #ffffff;
  border-color: rgba(255, 255, 255, 0.24);
}

.toolbar-btn:active {
  transform: scale(0.97);
}

.zoom-level-btn {
  font-variant-numeric: tabular-nums;
  min-width: 3.5rem;
  font-size: 0.82rem;
}

.toolbar-divider {
  width: 1px;
  height: 1.4rem;
  background: rgba(255, 255, 255, 0.12);
  margin: 0 0.25rem;
}

.close-btn {
  background: rgba(239, 68, 68, 0.18);
  border-color: rgba(239, 68, 68, 0.35);
  color: #fca5a5;
  padding-left: 0.75rem;
  padding-right: 0.75rem;
}

.close-btn:hover {
  background: rgba(239, 68, 68, 0.35);
  border-color: rgba(239, 68, 68, 0.6);
  color: #ffffff;
}

.close-label {
  font-size: 0.85rem;
}

/* Canvas & Viewport */
.diagram-canvas {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  cursor: grab;
  position: relative;
  background-image: radial-gradient(rgba(255, 255, 255, 0.08) 1px, transparent 1px);
  background-size: 24px 24px;
}

.diagram-canvas.dragging {
  cursor: grabbing;
}

.diagram-viewport {
  display: flex;
  align-items: center;
  justify-content: center;
  max-width: 92vw;
  max-height: 85vh;
  transform-origin: center center;
  will-change: transform;
}

.diagram-svg-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.02);
  border-radius: 12px;
}

.diagram-svg-wrapper :deep(svg) {
  max-width: 88vw;
  max-height: 80vh;
  width: auto;
  height: auto;
  filter: drop-shadow(0 10px 30px rgba(0, 0, 0, 0.5));
}

.diagram-img {
  max-width: 88vw;
  max-height: 80vh;
  object-fit: contain;
  border-radius: 8px;
  filter: drop-shadow(0 10px 30px rgba(0, 0, 0, 0.5));
}

/* Footer Hint */
.diagram-hint {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  padding: 0.6rem 1rem;
  font-size: 0.78rem;
  color: #94a3b8;
  background: rgba(18, 28, 48, 0.6);
  border-top: 1px solid rgba(255, 255, 255, 0.06);
  pointer-events: none;
}

.diagram-hint strong {
  color: #e2e8f0;
}

.dot {
  opacity: 0.4;
}

/* Animations */
.diagram-fade-enter-active,
.diagram-fade-leave-active {
  transition: opacity 0.2s ease;
}

.diagram-fade-enter-from,
.diagram-fade-leave-to {
  opacity: 0;
}
</style>
