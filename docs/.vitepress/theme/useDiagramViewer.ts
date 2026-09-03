import { ref } from 'vue'

export interface DiagramPayload {
  type: 'svg' | 'image'
  content: string // SVG markup or image URL
  title?: string
}

const isOpen = ref(false)
const currentDiagram = ref<DiagramPayload | null>(null)

export function useDiagramViewer() {
  function open(diagram: DiagramPayload) {
    currentDiagram.value = diagram
    isOpen.value = true
    if (typeof document !== 'undefined') {
      document.body.style.overflow = 'hidden'
    }
  }

  function close() {
    isOpen.value = false
    currentDiagram.value = null
    if (typeof document !== 'undefined') {
      document.body.style.overflow = ''
    }
  }

  return {
    isOpen,
    currentDiagram,
    open,
    close,
  }
}
