describe('add to cart', () => {

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

  it("should increase cart by one after add to cart is clicked", () => {
    cy.visit('/', {
      auth: {
        username: 'Jungle',
        password: 'book'
      },
    });
    cy.contains('My Cart (0)');
    cy.contains("Add").first().click({ force: true });
    cy.contains('My Cart (1)');

  });

});