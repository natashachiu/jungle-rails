describe('product details page', () => {

  it('should render home page', () => {
    cy.visit('/', {
      auth: {
        username: 'Jungle',
        password: 'book'
      },
    });
  });

  it('should render products on home page', () => {
    cy.get(".products article").should("be.visible");
  });

  it("should render 2 products on home page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('should render product details page when clicked', () => {
    cy.visit('/', {
      auth: {
        username: 'Jungle',
        password: 'book'
      },
    });
    cy.get(".products article").first().click();
    cy.url().should("include", "/products/3");

  });

});