describe("home", () => {
  it("is just an index placeholder for now", () => {
    cy.visit("/");
    cy.contains("Coming eventually");
  });
});
