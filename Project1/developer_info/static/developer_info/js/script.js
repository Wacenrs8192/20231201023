class SectionManager {
    constructor() {
        this.contentElement = document.getElementById('content');
        this.titleElement = document.getElementById('section-title');
        this.buttons = document.querySelectorAll('.section-btn');
        this.baseUrl = '/developer/api/sections/';
        
        this.init();
    }
    
    init() {
        this.setupEventListeners();
        this.setupHistoryHandler();
    }
    
    setupEventListeners() {
        this.buttons.forEach(button => {
            button.addEventListener('click', (e) => {
                this.handleSectionClick(e.target);
            });
        });
    }
    
    setupHistoryHandler() {
        window.addEventListener('popstate', (event) => {
            if (event.state && event.state.section) {
                this.showSection(event.state.section, event.state.title, false);
            }
        });
    }
    
    async handleSectionClick(button) {
        const sectionId = button.dataset.section;
        const sectionTitle = button.dataset.title;
        
        this.setLoadingState(true);
        
        try {
            await this.showSection(sectionId, sectionTitle, true);
        } catch (error) {
            this.handleError(error);
        } finally {
            this.setLoadingState(false);
        }
    }
    
    async showSection(sectionId, sectionTitle, updateHistory = true) {
        try {
            const response = await fetch(`${this.baseUrl}${sectionId}/`);
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            const content = await response.text();
            
            this.updateContent(content, sectionTitle);
            
            if (updateHistory) {
                history.pushState(
                    { section: sectionId, title: sectionTitle },
                    "",
                    `section${sectionId}`
                );
            }
            
        } catch (error) {
            console.error('Error fetching section:', error);
            throw error;
        }
    }
    
    updateContent(content, title) {
        this.titleElement.textContent = title;
        this.contentElement.innerHTML = `<div class="content-success">${content}</div>`;
        this.contentElement.classList.remove('content-error');
    }
    
    handleError(error) {
        this.titleElement.textContent = 'Error';
        this.contentElement.innerHTML = `
            <div class="content-error">
                <p>Unable to load content. Please try again.</p>
                <small>Error: ${error.message}</small>
            </div>
        `;
        this.contentElement.classList.add('content-error');
    }
    
    setLoadingState(isLoading) {
        this.buttons.forEach(button => {
            button.disabled = isLoading;
            if (isLoading) {
                button.classList.add('loading');
            } else {
                button.classList.remove('loading');
            }
        });
        
        if (isLoading) {
            this.contentElement.innerHTML = '<p class="placeholder-text">Loading content...</p>';
        }
    }
}

// Initialize the section manager when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new SectionManager();
});