<script setup lang="ts">
import mermaid from 'mermaid'
import { onMounted, ref, watch } from 'vue'
import { useData } from 'vitepress'
import { useDiagramViewer } from './useDiagramViewer'

const props = defineProps<{
  graph: string
  id: string
}>()

const { isDark } = useData()
const { open } = useDiagramViewer()
const svg = ref('')
const error = ref('')
let renderNumber = 0

async function renderDiagram() {
  const currentRender = ++renderNumber
  error.value = ''

  try {
    mermaid.initialize({
      startOnLoad: false,
      securityLevel: 'strict',
      theme: isDark.value ? 'dark' : 'neutral',
    })

    const result = await mermaid.render(
      `${props.id}-${currentRender}`,
      decodeURIComponent(props.graph),
    )

    if (currentRender === renderNumber) {
      svg.value = result.svg
    }
  } catch (caught) {
    if (currentRender === renderNumber) {
      error.value = caught instanceof Error ? caught.message : String(caught)
    }
  }
}

function expandDiagram() {
  if (!svg.value) return
  open({
    type: 'svg',
    content: svg.value,
    title: 'Architecture Diagram'
  })
}

onMounted(renderDiagram)
watch(isDark, renderDiagram)
</script>

<template>
  <div v-if="svg" class="mermaid-container" @click="expandDiagram">
    <div class="mermaid-toolbar">
      <button
        type="button"
        class="expand-btn"
        title="Open full screen with zoom and pan"
        aria-label="Open diagram in full screen"
        @click.stop="expandDiagram"
      >
        <svg viewBox="0 0 24 24" width="14" height="14" fill="currentColor">
          <path d="M7 14H5v5h5v-2H7v-3zm-2-4h2V7h3V5H5v5zm12 7h-3v2h5v-5h-2v3zM14 5v2h3v3h2V5h-5z" />
        </svg>
        <span>Expand & Zoom</span>
      </button>
    </div>
    <div class="mermaid-diagram" v-html="svg" />
  </div>
  <pre v-else-if="error" class="mermaid-error">Diagram could not be rendered: {{ error }}</pre>
  <div v-else class="mermaid-loading" aria-live="polite">Rendering diagram…</div>
</template>

<style scoped>
.mermaid-container {
  position: relative;
  margin: 1.75rem 0;
  padding: 1.25rem 1rem 1rem;
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  border-radius: 8px;
  overflow: hidden;
  cursor: zoom-in;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.mermaid-container:hover {
  border-color: var(--vp-c-brand-1);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
}

.mermaid-toolbar {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
  z-index: 2;
  opacity: 0.85;
  transition: opacity 0.2s ease;
}

.mermaid-container:hover .mermaid-toolbar {
  opacity: 1;
}

.expand-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  padding: 0.3rem 0.6rem;
  font-size: 0.75rem;
  font-weight: 500;
  color: var(--vp-c-text-2);
  background: var(--vp-c-bg);
  border: 1px solid var(--vp-c-divider);
  border-radius: 6px;
  cursor: pointer;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  transition: all 0.15s ease;
}

.expand-btn:hover {
  color: var(--vp-c-brand-1);
  border-color: var(--vp-c-brand-1);
  background: var(--vp-c-bg-mute);
}

.mermaid-diagram {
  overflow-x: auto;
  text-align: center;
}

.mermaid-diagram :deep(svg) {
  height: auto;
  max-width: 100%;
}

.mermaid-error {
  overflow-x: auto;
  color: var(--vp-c-danger-1);
  white-space: pre-wrap;
  padding: 1rem;
  background: var(--vp-c-bg-soft);
  border-radius: 8px;
}

.mermaid-loading {
  color: var(--vp-c-text-2);
  padding: 1.5rem 0;
  text-align: center;
}
</style>
