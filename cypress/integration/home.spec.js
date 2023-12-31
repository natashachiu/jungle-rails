describe('home page', () => {

  it('should render home page', () => {
    cy.visit('/');
  });

  it('should render products on home page', () => {
    cy.get(".products article").should("be.visible");
  });

  it("should render 2 products on home page", () => {
    cy.get(".products article").should("have.length", 2);
  });

});